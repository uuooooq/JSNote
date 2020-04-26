import React from 'react';
import './App.css';
import { Affix, Button, List, Divider, Radio } from 'antd';
import { Layout } from 'antd';
import TextareaAutosize from 'react-textarea-autosize';
import 'antd/dist/antd.css';
const { Content } = Layout;

//const httpPre = 'http://'+window.location.host //http://192.168.1.103:8080
const httpPre = 'http://192.168.1.4:8080'
const imgPre = httpPre+'/file?imageName='


var listData = [];


var storage = window.localStorage
if (storage) {
  storage.removeItem('personalStorage')
  var tmpListData = JSON.parse(storage.getItem('personalStorageNew'))
  if (!tmpListData) {
    storage.setItem('personalStorageNew', JSON.stringify(listData))
  }

}



export default class App extends React.Component {


  state = {
    value: 1,
    myData: [],
    inputValue: '',
  };


  onChange = e => {
    console.log('radio checked', e.target.value);
    this.setState({
      value: e.target.value,
    });
  };



  componentWillMount() {
    this.fetchData()
    document.addEventListener("keydown", this.onKeyDown)

  }

  componentWillUnmount() {
    document.removeEventListener("keydown", this.onKeyDown)
  }

  onKeyDown = (e) => {
    // eslint-disable-next-line default-case
    console.log('you press key ' + e.keyCode)
    // switch( e.keyCode) {
    //   case 13://回车事件
    //     break
    //   default:
    //     break
    // }
    if (83 == e.keyCode && e.ctrlKey) {
      window.event.preventDefault()//
      window.event.cancelBubble = true//IE
      this.onSave();
      console.log('you press key keydown ' + e.keyCode)
    }
    if (67 == e.keyCode && e.ctrlKey) {
      window.event.preventDefault()//
      window.event.cancelBubble = true//IE
      this.setState({
        inputValue: '',
      })
      console.log('you press key keydown ' + e.keyCode)
    }
    if (70 == e.keyCode && e.ctrlKey) {
        window.event.preventDefault()//
        window.event.cancelBubble = true//IE
        this.setState({
          myData: [],
        })
        this.searchData()
      console.log('you press key keydown ' + e.keyCode)
    }
  }

  handleChange(e) {
    // console.log(e.target.value)
    this.setState({
      inputValue: e.target.value
    })
  }

  onSave(e) {

    if(this.state.inputValue.length <1){
      return;
    }

    this.sendToServer(this.state.inputValue)
    //this.state.myData.
    if (tmpListData) {
      this.setState({
        inputValue: '',
      })
    }
  }

  fetchData() {
    fetch(httpPre + '/hello?start=0&end=100')
      .then((response) => {
        if (!response.ok) throw new Error(response.status);
        else return response.json();
      })
      .then((data) => {
        this.setState({ myData: data });
        console.log(data);
      })
      .catch((error) => {
        console.log('error: ' + error);
        this.setState({ requestFailed: true });
      });

  }

  searchData(){
    fetch(httpPre+'/search?searchWord='+this.state.inputValue).then((response) => {
      if (!response.ok) throw new Error(response.status);
      else return response.json();
    })
    .then((data) =>{
      this.setState({ myData: data });
      console.log(data);
    })
    .catch((error) => {
      console.log('error: ' + error);
      this.setState({ requestFailed: true });
    });
  }

  sendToServer(valueStr) {
    let url = httpPre//"http://192.168.1.6:8080";
    let formData = new FormData();

    formData.append('value', valueStr);

    fetch(url, {
      method: 'post',
      body: formData,
    }).then((response) => {
      if (!response.ok) throw new Error(response.status);
      else return response.json();
    })
      .then((data) => {
        this.setState({ myData: data });
        console.log(data);
      })
      .catch((error) => {
        console.log('error: ' + error);
        //this.setState({ requestFailed: true });
      });
  }

  createTextDisplay(value) {

    if(value.type == '2' || value.type.inputValue == 2){
      return(
        <div>
        <img height={360} src={imgPre+value.value} />
      </div>
      )
    }
    else{
      return (
        <div>
          <pre>{value.value}</pre>
          
        </div>
      );
    }


  }


  render() {

    return (

      <div>
        <Layout>
          <Content>
            <Affix offsetTop={0} >
              <div style={{ display: 'flex', width: '100%', flexDirection: 'column' }}>
                <div style={{ display: 'flex', width: '100%', backgroundColor: 'white', flexDirection: 'row', justifyContent: 'flex-end', alignItems: 'baseline' }}>
                  <Button>取消(ctrl+c)</Button>
                  <Button onClick={this.onSave.bind(this)} >保存(ctrl+s)</Button>
                </div>
                <div style={{ display: 'flex', width: '100%', backgroundColor: 'gray', flexDirection: 'row' }}>
                  <TextareaAutosize onChange={this.handleChange.bind(this)} placeholder="请输入内容" value={this.state.inputValue} style={{ flexGrow: '1' }} />
                </div>

              </div>
            </Affix>
            <div style={{ display: 'flex', flex: '1', flexDirection: 'column', backgroundColor: 'white' }}>
              <List
                itemLayout="horizontal"
                dataSource={this.state.myData}
                size="large"
                renderItem={item => (
                  <div style={{ display: 'flex', flex: '1', flexDirection: 'column',marginRight:200,marginLeft:200 }}>
                    <div style={{ display: 'flex', flex: '1', padding: '10px' }}>
                      {this.createTextDisplay(item)}
                    </div>

                    <Divider></Divider>
                  </div>

                )}
                pagination={{
                  onChange: page => {
                    console.log(page);
                  },
                  pageSize: 30,
                }}
              />
            </div>


          </Content>

        </Layout>

      </div>
    );
  }
}

//<pre>{item.value}</pre>
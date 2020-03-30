import React from 'react';
//import logo from './logo.svg';
import './App.css';
//import ScrollList from './scrollList'
import { Input, Affix, Button, List, Divider, Radio } from 'antd';
import { Layout } from 'antd';
import TextareaAutosize from 'react-textarea-autosize';
//import { MessageOutlined, LikeOutlined, StarOutlined } from '@ant-design/icons';
//import reqwest from 'reqwest';
import { GET } from 'react-axios'
import axios from 'axios'
import 'antd/dist/antd.css';
const { Content } = Layout;
const { Search } = Input;

const httpPre = 'http://'+window.location.host

// var listData = [];
// for (let i = 0; i < 23; i++) {
//   listData.push({
//     href: 'http://ant.design',
//     title: `ant design part ${i}`,
//     avatar: 'https://zos.alipayobjects.com/rmsportal/ODTLcjxAfvqbxHnVXCYX.png',
//     description:
//       'Ant Design, a design language for background applications, is refined by Ant UED Team.',
//     content:
//       'We supply a series of design principles, practical patterns and high quality design resources (Sketch and Axure), to help people create their product prototypes beautifully and efficiently.',
//   });
// }  

var listData = [];
// for (let i = 0; i < 23; i++) {
//   listData.push({
//     key: 'http://ant.design',
//     value: '这是一段记录',
//     createTime: '',
//     extCategory:{'type':'text'},
//   });
// } 

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
    // if (storage) {
    //   var tmpListData = JSON.parse(storage.getItem('personalStorageNew'))
    //   if (tmpListData) {
    //     this.setState({
    //       myData: tmpListData,
    //     })
    //   }
    //   //console.log('from will mount' + tmpListData)
    // }

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
  }

  handleChange(e) {
    // console.log(e.target.value)
    this.setState({
      inputValue: e.target.value
    })
  }

  onSave(e) {

    // if (storage) {
    //   var tmpListData = JSON.parse(storage.getItem('personalStorageNew'))
    // var timestamp = (new Date()).valueOf();
    // this.state.myData.unshift({
    //   key: `${timestamp}`,
    //   value: this.state.inputValue,
    //   createTime: timestamp,
    //   extCategory: { 'type': 'text' },
    // })
    //   storage.setItem('personalStorageNew', JSON.stringify(tmpListData))
    this.sendToServer(this.state.inputValue)
    //this.state.myData.
    if (tmpListData) {
      this.setState({
        inputValue: '',
      })
    }
    //this.fetchData()


    //}

    //console.log(this.state.inputValue);
  }

  fetchData() {
    fetch(httpPre+'/hello?start=0&end=100')
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

    // fetch('http://192.168.1.6:8080/hello?start=0&end=100',{
    //   method:'GET',
    //   // header:{
    //   //   'Control-Type':'application/json'
    //   // },
    //   mode: 'no-cors',
    // }).then(res => {
    //   //var tmp = res.body()
    //   //console.log(res.json())
    //   if(res.ok){
    //     res.json().then((data) => {
    //       console.log('can you see'+data)
    //     })
    //   }else{
    //     console.log(res.status)
    //   }
    // }).catch(err =>{
    //   console.log('错误'+err)
    // })
    // var a = {}
    // reqwest({
    //     url:"http://192.168.1.6:8080/hello?start=0&end=100",
    //     type:"json",
    //     method:"get",
    //     mode: 'no-cors',
    //     header:{
    //       'Access-Control-Allow-Origin':'*'
    //     },
    //     data:{tag:"life"},
    //     success:function (resp) {
    //         a = resp
    //         console.log(resp)
    //     }
    // })

    // axios.get('http://192.168.1.6:8080/hello?start=0&end=100').then(function (response) {
    //   console.log(response.data)

    // })
    // .catch(function (error) {
    //   console.log(error);
    // })

  }

  sendToServer(valueStr) {
    // fetch('http://192.168.1.6:8080',{
    //   method:'POST',
    //   headers:{
    //     'Content-type':'application/x-www-form-urlencoded'
    //   },
    //   body:JSON.stringify({
    //     'value':valueStr,
    //   })
    // })

    // let formdata = new FormData();
    // formdata.append("name","admin");
    // fetch("http://192.168.1.6:8080",{
    //     method:"POST",
    //     headers:{
    //       'Content-Type':'application/x-www-form-urlencoded'
    //     },
    //     body:formdata
    // }).then(function(response){
    //     console.log(response);
    // })
    let url = httpPre//"http://192.168.1.6:8080";
    let formData = new FormData();
    //formData.append('c','login');
    formData.append('value', valueStr);
    //formData.append('password', valueStr);
    //formData.append('client', 'android');

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
    return (
      <div>
        <pre>{value}</pre>
      </div>
    );
  }

  render() {

    return (

      <div>
        <Layout>
          <Content>
            <Affix offsetTop={0} >
              <div style={{ display: 'flex', width: '100%', flexDirection: 'column' }}>
                <div style={{ display: 'flex', width: '100%', backgroundColor: 'white', flexDirection: 'row', justifyContent: 'flex-end', alignItems: 'baseline' }}>
                  {/* <Button>添加照片，视频等文件</Button>
                <Button style={{ flexGrow: '1' }}>代码</Button> */}
                  <div style={{ display: 'flex', width: '100%', backgroundColor: 'white', flexDirection: 'row', justifyContent: 'flex-start' }}>
                    <Radio.Group onChange={this.onChange.bind(this)} value={this.state.value}>
                      <Radio value={1}>文本</Radio>
                      <Radio value={2}>文件</Radio>
              <Radio value={3}>代码{httpPre}</Radio>
                    </Radio.Group>
                  </div>
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
                  <div style={{ display: 'flex', flex: '1', flexDirection: 'column' }}>
                    <div style={{ display: 'flex', flex: '1', padding: '10px' }}>
                      <pre>{item.value}</pre>
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


{/* <Affix offsetTop={0}>
<div style={{ width: '100%' }}>
  <Search
    placeholder="input search text"
    onSearch={value => console.log(value)}
    style={{ width: '100%' }}
  />
</div>
</Affix> */}
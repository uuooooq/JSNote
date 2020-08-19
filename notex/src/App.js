import React from 'react';
import './App.css';
import { Affix, Button, Table, List,Typography } from 'antd';
import { Layout } from 'antd';
import TextareaAutosize from 'react-textarea-autosize';
import 'antd/dist/antd.css';
//import {FolderOutlined} from '@ant-design/icons'



const { Content } = Layout;
//import { Upload, message, Button } from 'antd';
//import { UploadOutlined } from '@ant-design/icons';


//const httpPre = 'http://'+window.location.host 
const httpPre = 'http://192.168.4.100:8080'
const imgPre = httpPre + '/file?imageName='
const uploadUrl = httpPre + '/upload'

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


  constructor(props) {
    super(props);
    this.fileInput = React.createRef();
  }


  onChange = e => {
    console.log('radio checked1', e.target.value);
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

    if (this.state.inputValue.length < 1) {
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

  searchData() {
    fetch(httpPre + '/search?searchWord=' + this.state.inputValue).then((response) => {
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

  showDetailView(value) {

    alert('show detail view' + value.value);

  }

  createTextDisplay(value) {

    if (value.type == '2' || value.type.inputValue == 2) {
      return (
        <div>
          <Button onClick={this.showDetailView.bind(this, value)}>更多</Button>
          <img height={360} src={imgPre + value.value} />
        </div>
      )
    }
    else {
      return (
        <div>
          <Button onClick={this.showDetailView.bind(this, value)}>更多</Button>
          <pre>{value.value}</pre>


        </div>
      );
    }


  }

  onSaveFile(e) {
    alert('hello world');
    var form = new FormData()

    var fileObj = this.fileInput.current.files[0] //document.getElementById("file").files[0]

    form.append("files[]", fileObj) //uploadFile为后台给的参数名

    fetch(uploadUrl, {

      method: 'POST',

      body: form,

    }).then(function (response) {
      alert('上传成功')
      return response.json();

    }).then((e) => {

      console.log(e)
      alert('上传失败' + e)
    })
  }





  render() {

    const column = [
      {
        title: '',
        dataIndex: 'value',
        key: 'value',
        render: text => <a>{text}</a>
      }
    ];

    return (


      <div style={{ display: 'flex', flex: '1', flexDirection: 'column', backgroundColor: 'white' }}>
        {/* <Table 
                columns={column} 
                dataSource={this.state.myData} 
                pagination={{pageSize:20}}
                onRow={(record) => {
                  return {
                    onClick:() => {
                      alert(record.value)
                    }
                  }
                } }
                ></Table> */}
        <List
          dataSource={this.state.myData}
          renderItem={item => (
            <List.Item>
               {item.value}
            </List.Item>
          )}
        />
      </div>
    );
  }
}

//<pre>{item.value}</pre>
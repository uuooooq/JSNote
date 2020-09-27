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
const httpPre = 'http://192.168.4.102:8080'
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
    super();
    this.fileInput = React.createRef();
  }


  componentWillMount() {
    this.fetchData()
    

  }

  componentWillUnmount() {
  
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
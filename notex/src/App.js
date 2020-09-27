import React from 'react';
import './App.css';
import { Affix, Button, Table, List, Typography } from 'antd';
import { Layout, Avatar } from 'antd';
import TextareaAutosize from 'react-textarea-autosize';
import 'antd/dist/antd.css';
import { FolderOutlined } from '@ant-design/icons';

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
    value: "**Hello world!!!**",
    selectedTab: "write" | "preview">("write"),
    inputValue: '',
  };



  // componentDidMount() {
  //   this.focusEditor();
  // }


  // constructor(props) {
  //   super();
  //   this.fileInput = React.createRef();
  //   //this.handleValueChange = this.handleValueChange.bind();
  // }


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

  handleChange(e) {
    // console.log(e.target.value)
    this.setState({
      inputValue: e.target.value
    })
  }

  render() {


    return (


      <div style={{ display: 'flex', flex: '1', flexDirection: 'row', backgroundColor: 'white', margin: 20 }}>

        <div style={{ flex: 1 }}>
          <List
            dataSource={this.state.myData}
            renderItem={item => (
              <List.Item>
                <List.Item.Meta
                  title={<a href="https://ant.design">{item.value}</a>}
                  description={item.createTime}
                />

              </List.Item>
            )}
          />
        </div>

        <div style={{ flex: 1 }}>

        </div>


      </div>
    );
  }
}

//<pre>{item.value}</pre>

const styles = {
  editor: {
    border: '1px solid gray',
    minHeight: '6em',
    height:'100%',
  }
};
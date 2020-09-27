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

  onChange = e => {
    console.log('radio checked1', e.target.value);
    this.setState({
      value: e.target.value,
    });
  };
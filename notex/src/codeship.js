<List
itemLayout="horizontal"
dataSource={this.state.myData}
size="large"
onClick={this.showDetailView.bind(this)}
renderItem={item => (
  <div style={{ display: 'flex', flex: '1', flexDirection: 'column', marginRight: 200, marginLeft: 200 }} onclick={this.showDetailView.bind(this,item)}>
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

<Affix offsetTop={0} >
<div style={{ display: 'flex', width: '100%', flexDirection: 'column' }}>
  <div style={{ display: 'flex', width: '100%', backgroundColor: 'white', flexDirection: 'row', justifyContent: 'flex-end', alignItems: 'baseline' }}>
    {/* <Button onClick={this.onSaveFile.bind(this)}>添加文件</Button> */}
    <div>
    <input type="file" name='file' ref={this.fileInput}/>
  <input type="button" value="上传" onClick={this.onSaveFile.bind(this)}/>
    </div>
    <Button>取消(ctrl+c)</Button>
    <Button onClick={this.onSave.bind(this)} >保存(ctrl+s)</Button>
  </div>
  <div style={{ display: 'flex', width: '100%', backgroundColor: 'gray', flexDirection: 'row' }}>
    <TextareaAutosize onChange={this.handleChange.bind(this)} placeholder="请输入内容" value={this.state.inputValue} style={{ flexGrow: '1' }} />
  </div>

</div>
</Affix>
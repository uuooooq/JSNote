//import loadAccount from 'my-account-loader';
import React from 'react';
import ReactList from 'react-list';

class ScrollList extends React.Component {
  state = {
    accounts: [{name:"hello"},{name:"hello"},{name:"hello"},{name:"hello"}]
  };

  componentWillMount() {
    //this.loadAccounts(this.handleAccounts.bind());
    var arr = [];
    for(var i = 0; i< 1000;i++){
        var extStr = ""
        if(i === 10){
            extStr = 'skdjfskldfjklsdjflksdfjklsdfjksldfjlksdfjksldfjsklfjksldfjklsdfjksldjfkldsjfklsdfjkl'
        }
        arr.push({name:"value is "+i+" "+extStr})
    }
    this.setState({
        accounts:arr
    })
  }

  renderItem(index, key) {
    return <div key={key} style={{borderWidth:30,margin:30,backgroundColor:"red",borderWidth: 2,borderColor: '#000000',borderStyle: 'solid'}}>{this.state.accounts[index].name}</div>;
  }

  render() {
    return (
        <div style={{overflow: 'auto', maxHeight: 400}}>
          <ReactList
            itemRenderer={this.renderItem.bind(this)}
            length={this.state.accounts.length}
            type='uniform'
          />
          
        </div>
    );
  }
}

export default ScrollList
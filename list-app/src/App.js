import React, { Component } from 'react';
import logo from './logo.svg';
import './App.css';
import axios from 'axios';
import ReactTable from "react-table";
import "react-table/react-table.css";
import matchSorter from 'match-sorter';

const columns = [
    {
      Header: "Jocelyn",
      columns: [
        {
          Header: "Quote",
          accessor: "quote",
          filterMethod: (filter, rows) =>
                    matchSorter(rows, filter.value, { keys: ["quote"] }),
                  filterAll: true
        },
        {
          Header: "Context",
          accessor: "context",
          filterMethod: (filter, rows) =>
                    matchSorter(rows, filter.value, { keys: ["context"] }),
                  filterAll: true
        },
         {
          Header: "Source",
          accessor: "source",
          filterMethod: (filter, rows) =>
                    matchSorter(rows, filter.value, { keys: ["source"] }),
                  filterAll: true
        },
        {
          Header: "Theme",
          accessor: "theme",
          filterMethod: (filter, rows) =>
                    matchSorter(rows, filter.value, { keys: ["theme"] }),
                  filterAll: true
          
        }
      ]
    }
  ]

class App extends Component {

  constructor(props) {
    super(props);
    this.state = {
      list: []
    };
  }

  componentDidMount() {
    axios.get('https://gist.githubusercontent.com/anonymous/8f61a8733ed7fa41c4ea/raw/1e90fd2741bb6310582e3822f59927eb535f6c73/quotes.json')
      .then(response => {
        const data = response.data;
        console.log(this.state);
        this.setState({ list: data })
        console.log(this.state);
      }
    );

  }

  render() {
    console.log('this is data',this.state.list)
    return (
      <div className="App">
        <ReactTable
          data={this.state.list}
          defaultPageSize = {5}
          filterable
          defaultFilterMethod={(filter, row) => String(row[filter.id]) === filter.value}
          columns={columns}
        />
      </div>
    );
  }

}

export default App;
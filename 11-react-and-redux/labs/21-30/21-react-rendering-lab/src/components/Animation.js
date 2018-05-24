import React from "react";

export default class Animation extends React.Component {
  constructor(props) {
    super(props);

    this.state = {
      url: "http://placehold.it/500x150",
    };
  }

  componentWillUpdate = () => this.showLoadingBar();

  getNewCat = () => {
    fetch("http://api.giphy.com/v1/gifs/random?rating=g&api_key=dc6zaTOxFJmzC")
      .then((res, err) => {
        if (err) {
          console.log("Something went wrong with fetching your new cat!", err);
        } else {
          return res.json();
        }
      })
      .then(result =>
        this.setState({
          url: result.data.fixed_height_downsampled_url,
        })
      );
  };

  showLoadingBar = () => {
    const progressBar = document.getElementById("progress-bar");
    progressBar.className = "off on";
    setTimeout(() => (progressBar.className = "off"), 1100);
  };

  render() {
    return (
      <div>
        <img src={this.state.url} height="100px" />
        <div>
          <button onClick={this.getNewCat}>New random .gif!</button>
        </div>
      </div>
    );
  }
}


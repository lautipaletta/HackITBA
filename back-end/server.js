const mongoose = require("mongoose");

mongoose.connect("mongodb://mongo:27017/crowdfunding");

const express = require("express");
const raiserRouter = require("./raisers");

const cors = require("cors");
const helmet = require("helmet");

const app = express();

app.use(cors());
app.use(helmet());
app.use(express.json());

app.use("/raiser", raiserRouter);

const {modelCrowdFund} = require("./models/crowdFundModel");

var port = 3000;

app.listen(port, () => {
    console.log("Listening on port " + port);
});

app.get('/', (req, res) => {
    console.log("Request got");
    res.send("GET Request Called");
});

const { Schema, model } = require("mongoose");
//const modelCrowdFund = require("./crowdFundModel");

const schemaRaiser = new Schema({
        id: String,
        name: String,
        password: String,
        description: String,
        contactInfo: String,
        profileImageUrl: String//,
        //crowdfunds: [modelCrowdFund]
});

const modelRaiser = new model("raisers", schemaRaiser);

module.exports = modelRaiser;

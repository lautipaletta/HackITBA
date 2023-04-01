const { Schema, model, STATES } = require("mongoose");
const {schemaCroudFund} = require("./crowdFundModel");

const schemaRaiser = new Schema({
        id: String,
        name: String,
        password: String,
        description: String,
        contactInfo: String,
        profileImage: String,
        crowdfundsIds: [String],
        address: String
});

const modelRaiser = new model("raisers", schemaRaiser);

module.exports = modelRaiser;

const fuzzy = require("mongoose-fuzzy-search");
const { Schema, model } = require("mongoose");

const schemaCrowdFund = new Schema({
        id: String,
        state: Number,
        title: String,
        description: String,
        receiverDescription: String,
        goalAmount: String,
        deadline: Number,
        images: String,
        //resultImages: [String],
        resultComments: String,
        contractAddress: String,
        receiverAddress: String,
        idOfRaiser: String
});

schemaCrowdFund.plugin(fuzzy, {fields: {title_: "title"}});

const modelCrowdFund = new model("crowdFunds", schemaCrowdFund);

module.exports = modelCrowdFund;

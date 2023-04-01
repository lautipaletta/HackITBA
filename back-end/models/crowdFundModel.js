const { Schema, model } = require("mongoose");

const schemaCrowdFund = new Schema({
        id: String,
        active: Boolean,
        title: String,
        description: String,
        receiverDescription: String,
        goalAmount: Number,
        deadline: Number,
        images: [String],
        resultImages: [String],
        resultComments: String,
        contractAddress: String,
        receiverAddress: String,
        idOfRaiser: String
});

const modelCrowdFund = new model("crowdFunds", schemaCrowdFund);

module.exports = modelCrowdFund;

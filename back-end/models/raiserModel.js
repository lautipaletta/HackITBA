const { Schema, model } = require("mongoose");

const schemaRaiser = new Schema({
        id: String,
        name: String,
        password: String,
        description: String,
        contactInfo: String,
        profileImage: String,
        crowdFundsIds: [String],
        address: String
});

const modelRaiser = new model("raisers", schemaRaiser);

module.exports = modelRaiser;

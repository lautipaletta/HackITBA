const express = require("express");
const mongo = require("mongodb");
const course = require("course");
const helmet = require("helmet");
const app = express();

app.use(course());
app.use(helmet());

var port = 5500;
const url = 'http://localhost:'+port;
const client = new MongoClient(url);

app.listen(port);
console.log('Server started! At http://localhost:' + port);

const dbRaisers = client.db("Raisers");
const collRaisers = dbRaisers.collection('documents');

app.get('/getRaiser', async function(req, res) {
    console.log('receiving data ...');
    console.log('body is ',req.body);
    raiser = await dbRaisers.findOne({id: req.body});
    response = {
        id: raiser.id,
        name: raiser.name,
        description: raiser.description,
        contactInfo: raiser.contactInfo,
        profileImageUrl: raiser.profileImageUrl,
        crowdfunds: raiser.crowdfunds
    };
    res.send(JSON.parse(response));
});

app.post('/newRaiser', async function(req, res) {
    console.log('receiving data ...');
    console.log('body is ', req.body);
    await collRaisers.insertOne(req.body);
    res.send(req.body);
});
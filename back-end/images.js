const fs = require("fs");

function saveImage(imageData, id, filename) {
    try{
    const fileToSave = Buffer.from(imageData, "base64");
    fs.writeFileSync(`images/${id}${filename}`, fileToSave, "utf8");
    }catch(e){console.log(e);}
    return `/images/${id}${filename}`;
}

module.exports = saveImage;

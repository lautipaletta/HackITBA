const fs = require("fs");

function saveImage(imageData) {
    const imageName = Date.now();

    const fileToSave = Buffer.from(imageData, "base64");
    fs.writeFileSync(`/app/images/${imageName}`, fileToSave);

    return imageName;
}

module.exports = saveImage;

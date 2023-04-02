const fs = require("fs");

function saveImage(imageData, id, filename) {
    const fileToSave = Buffer.from(imageData, "base64");
    fs.writeFileSync(`/app/images/${filename}`, fileToSave);

    return `/images/${id}${filename}`;
}

module.exports = saveImage;

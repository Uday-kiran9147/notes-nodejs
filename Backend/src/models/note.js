/* 
steps:
1.define schema => note: id,  userid,  title, content, date.
2.create model => <modelname> , <schema> Note.
*/

const mongoose = require('mongoose');
//SCHEMA
const noteSchema = mongoose.Schema({
    id: {
        type: String,
        unique: true,
        required: true,
    },
    userid: {
        type: String,
        required: true,
    },
    title: {
        type: String,
        required: true,
    },
    content: {
        type: String,
    },
    dateadded: {
        type: Date,
        default: Date.now,
    }
});

//MODEL
module.exports = mongoose.model("Notes", noteSchema);


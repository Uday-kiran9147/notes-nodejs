
//initialization
const express = require("express");
const app = express();
const mongoose = require("mongoose");
const Notes = require('./src/models/note');

const bodyparser = require('body-parser');   //dependency
mongoose.set('strictQuery', false);



app.use(bodyparser.urlencoded({ extended: false }));
/* 
 above:true -> nested objects allowed (correct)
            false ->nested objects not allowed (simple data)
*/
app.use(bodyparser.json());

const mongoDBpath = "mongodb+srv://uday:mongodb@cluster0.xvcpe7s.mongodb.net/notesApp";
mongoose.connect(mongoDBpath).then(function () {

    // we get access only when we connect to the above server(link)
    //App route, pages(/) (login, sigin, home pages).
    app.get("/", function (req, res) {
        const response = { message: "API works!" };
        res.json(response);
        res.send("This is the HOME page");
    });
    app.post("/notes/list", async function (req, res) {
        var notes = await Notes.find();
        res.json(notes);
        // res.send("This is NOTES Page");
    });
    app.post("/notes/add", async function (req, res) {

        await Notes.deleteOne({ id: req.body.id }); //deletes the notes if any 2 uid's are same 
        // res.json(req.body);
        const newNote = new Notes(
            {
                //We are giving dummy data(instance) for testing
                id: req.body.id,
                userid: req.body.userid,
                title: req.body.title,
                content: req.body.content,
            }
        );
        await newNote.save();

        const response = { message: `New Note Created id: ${req.body.id}` };

        res.json(response);
        // res.send("This is NOTES Page");
    });

    app.post("/notes/delete", async function (req, res) {
        await Notes.deleteOne({ id: req.body.id });
        const response = { message: `Note deleted! id ${req.body.id}` };
        res.json(response);
    });

});

//starting server on a port.

const PORT = process.env.PORT || 5000;  //if port is available then uses port number else 5000 is used
app.listen(PORT, function (req, res) {
    console.log("server started at port : " + PORT);
});

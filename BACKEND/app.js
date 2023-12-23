//---------------------- Required Packages -------------------------
const express = require('express');
const body_parser = require('body-parser');
const cookie_parser = require('cookie-parser');


const app = express();
const router = express.Router();

//---------------------- App Configs -------------------------
app.use(body_parser.urlencoded({extended:false}));
app.use(express.json());
app.use(cookie_parser());
//------------------------------------------------------------
app.listen(3000);
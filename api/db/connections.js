const dotenv = require("dotenv");
dotenv.config();

const mongoose = require("mongoose");

const connectDB = () => {
  return mongoose
    .connect("mongodb://127.0.0.1:27017/snake")
    .then(() => {
      console.log("connected");
    })
    .catch((err) => console.error(err));
};

module.exports = connectDB;

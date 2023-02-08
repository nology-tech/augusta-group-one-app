const dotenv = require("dotenv");
dotenv.config();

const mongoose = require("mongoose");

const connectDB = () => {
  return mongoose
    .connect(`${process.env.DB_IP}`)
    .then(() => {
      console.log("connected");
    })
    .catch((err) => console.error(err));
};

module.exports = connectDB;

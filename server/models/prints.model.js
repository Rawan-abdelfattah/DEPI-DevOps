const mongoose = require("mongoose")
const Schema = mongoose.Schema

const printsSchema = new Schema({
  teacher: { type: mongoose.Types.ObjectId, ref: "Teacher" },
  pdf: { type: mongoose.Types.ObjectId, ref: "Pdfs" },
  copies: { type: Number, required: true },
  cost: { type: Number, required: true },
  details: { type: String, trim: true },
  type: { type: String, trim: true  , enum :["teacher" , "client"]},
}, {
  timestamps: true
})

const Prints = mongoose.model("Prints", printsSchema)
module.exports = Prints 
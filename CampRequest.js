const mongoose = require("mongoose");

const campRequestSchema = new mongoose.Schema(
  {
    campId: String,
    itemName: String,
    requiredQty: Number,
    remainingQty: Number,
    status: String,
  },
  { timestamps: true }
);

module.exports = mongoose.model("CampRequest", campRequestSchema);

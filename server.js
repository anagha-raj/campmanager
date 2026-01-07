require("dotenv").config();

const express = require("express");
const mongoose = require("mongoose");
const cors = require("cors");

const CampRequest = require("./models/CampRequest");
const User = require("./models/User");
const Inventory = require("./models/Inventory");
const Donation = require("./models/Donation");

const app = express();

app.use(cors());
app.use(express.json());

// MongoDB connection
mongoose
  .connect(process.env.MONGO_URI)
  .then(() => {
    console.log("MongoDB Connected");
  })
  .catch((err) => {
    console.error("MongoDB connection error:", err);
  });

// Test route
app.get("/", (req, res) => {
  res.send("Camp Manager Backend Running");
});

// Get inventory for a specific camp
app.get("/inventory/:campId", async (req, res) => {
  try {
    const inventory = await Inventory.find({
      campId: req.params.campId,
    });
    res.json(inventory);
  } catch (error) {
    res.status(500).json({ message: "Error fetching inventory" });
  }
});

// Update inventory manually
app.put("/inventory/update", async (req, res) => {
  const { campId, itemName, quantity } = req.body;

  try {
    let item = await Inventory.findOne({ campId, itemName });

    if (item) {
      item.quantity = quantity;
      item.lastUpdated = new Date();
      await item.save();
    } else {
      item = await Inventory.create({
        campId,
        itemName,
        quantity,
      });
    }

    res.json({ message: "Inventory updated successfully" });
  } catch (error) {
    res.status(500).json({ message: "Inventory update failed" });
  }
});

// Create camp request
app.post("/camp-request", async (req, res) => {
  const { campId, itemName, requiredQty } = req.body;
  try {
    const doc = await CampRequest.create({
      campId,
      itemName,
      requiredQty,
      remainingQty: requiredQty,
      status: "Pending",
    });
    res.status(201).json(doc);
  } catch (err) {
    console.error("Create camp request error:", err);
    res.status(500).json({ message: "Failed to create camp request" });
  }
});

// Start server
const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});

const mongoose = require('mongoose');

const UserSchema = new mongoose.Schema({
  username: { type: String, required: true, unique: true },
  email: { type: String, required: true, unique: true },
  password: { type: String, required: true },
  location: { type: String, required: true },
}, { timestamps: true }); // Fixed the missing parenthesis and corrected 'timestamp' to 'timestamps'

module.exports = mongoose.model('User', UserSchema);

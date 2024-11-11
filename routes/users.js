const router = require('express').Router();
const userController = require('../controllers/usersControllers');
const {verifyToken} = require('../middleware/verifyToken');


// Define routes with corresponding controller methods
router.get('/', verifyToken, userController.getUser);
router.delete('/',verifyToken, userController.userDelete);


module.exports = router;
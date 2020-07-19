var express = require('express');
var router = express.Router();
const os = require('os');
const hostname = os.hostname();

/* GET home page. */
router.get('/', function(req, res, next) {
  res.json({
    hostname: hostname
  });
});

module.exports = router;

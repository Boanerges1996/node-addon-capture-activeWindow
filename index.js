var addon = require("bindings")("hello");
var addonTwo = require("bindings")("listen");
var addonThree = require("bindings")("mono");

addonThree.init((dd) => {});

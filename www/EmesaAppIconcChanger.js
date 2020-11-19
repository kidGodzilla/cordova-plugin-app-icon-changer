var exec = require('cordova/exec');

var EmesaAppIconcChanger = function () {};

EmesaAppIconcChanger.prototype.isSupported = function (onSuccess, onFail) {
    exec(onSuccess, onFail, "EmesaAppIconcChanger", "isSupported", []);
};

EmesaAppIconcChanger.prototype.changeIcon = function (options, onSuccess, onFail) {
    exec(onSuccess, onFail, "EmesaAppIconcChanger", "changeIcon", [options]);
};

EmesaAppIconcChanger.prototype.restIconToDefault = function (onSuccess, onFail) {
    exec(onSuccess, onFail, "EmesaAppIconcChanger", "restIconToDefault", []);
};

EmesaAppIconcChanger.prototype.getCurrentAlternateIconName = function (onSuccess, onFail) {
    exec(onSuccess, onFail, "EmesaAppIconcChanger", "getCurrentAlternateIconName", []);
};

module.exports = new AppIconChanger();
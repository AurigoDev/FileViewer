var plugins = {
    fileViewer: {
        openDocument: function (key, successCallback, failureCallback) {
         cordova.exec(successCallback, failureCallback, "FileViewer", "openDocument", [key]);
        }
    }
};

if (!window.aurigo) window.phonegap = {};

window.aurigo.plugins = plugins;

function openDocument(filePath, onSuccessCallback, onFailureCallback) {
    window.aurigo.plugins.fileViewer.openDocument(filePath, (onSuccessCallback) ? onSuccessCallback : function () { }, (onFailureCallback) ? onFailureCallback : function () { });
}

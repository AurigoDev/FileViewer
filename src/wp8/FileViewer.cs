using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Windows.Storage;
using Windows.Storage.Pickers;
using WPCordovaClassLib.Cordova;
using WPCordovaClassLib.Cordova.Commands;
using WPCordovaClassLib.Cordova.JSON;

namespace Cordova.Extension.Commands
{
    class CDVFileViewer : BaseCommand
    {
        
        public void openDocument(string options)
        {
            string optVal = JsonHelper.Deserialize<string[]>(options)[0];


            DefaultLaunch(optVal);

             
            //// Launch file open picker and caller app is suspended and may be terminated if required 
            DispatchCommandResult(new PluginResult(PluginResult.Status.OK, ""));
          
        }

        async void DefaultLaunch(string fileName)
        {

            fileName = fileName.Remove(0, 1);
            StorageFile  file = await ApplicationData.Current.LocalFolder.GetFileAsync(fileName);
             await Windows.System.Launcher.LaunchFileAsync(file);

        }
    }
}

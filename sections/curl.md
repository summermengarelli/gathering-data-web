# Using APIs from the Command Line

Using APIs from your browser is convenient for quick browsing, but APIs can be accessed by other methods that make it easier to download and work with data on your computer. A tool built for this purpose called `curl` (short for "Client URL") is built into all modern desktop operating systems. 

`curl` is built into the command line, or the text-based interface, of your operating system. In Windows, this is called **Command Prompt**, and you can open it by clicking the Windows button and starting to type `command`.

 In macOS, you open your Spotlight search and type in `terminal`. Similarly, in Linux you open your search bar and type in `terminal`.

> [!CAUTION]
> Windows contains another command line called Powershell, which shares some syntax with Command Prompt **but not all**. Notable `curl` works differently! If you use Powershell, you will need to enter `curl.exe` instead of just `curl` to avoid an error.

Your computer's command line usually opens to your user folder. You can see all the files and folders in your current location with a simple command. On Mac and Linux, the `ls` command will show you everything in this current folder, and on Windows, `dir` will do the same. You simply enter `ls` or `dir` and press enter. 

It is a good idea to "move" into folder where you can experiment, such as `Downloads` or  `Desktop`.In order to move locations, type `cd folder-name` where `folder-name` is the folder you want to be in. For example, we might enter `cd Downloads` then press enter to move into Downloads. 

From here, we can start playing with data! 

## Dictionary Download

The syntax for `curl` is `curl [options] [url]`, where `[options]` stands in for any optional flags that modify how `curl` behaves, and `[url]` is, in our case, the address for our API request. We will look at one of the optional flags in a moment, but first let's make a very basic API call to the Dictionary API by copying and pasting the below code into the command line:  

`curl https://api.dictionaryapi.dev/api/v2/entries/en/serendipity`

Once the command runs, we have made a successful API call using `curl`, and our output is JSON data defining the word *serendipity*. This is great, but in most cases we don't just want to see the results of an API request; we want to save those results to work with later. 

### The *-o* flag

In order to save our API response, we will add the optional flag *-o* to our command and specify the file name where we want it to be saved. Our syntax is now `curl -o [filename] [url]`. Remember that we should have moved to a good folder in which to experiment earlier (e.g., `Downloads` or `Desktop`). Unless we specify otherwise, any files we save in the command line using `curl -o` will be saved to that same folder. Try this:  

`curl -o serendipity.json https://api.dictionaryapi.dev/api/v2/entries/en/serendipity`  

## Image Download


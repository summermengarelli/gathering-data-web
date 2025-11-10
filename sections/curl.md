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

## Image Download

Let's say we wanted to download an image of a cat to our computer, and we want to make sure it's an image in the public domain so we can use it for whatever purpose. Remember what we might do?

Firts, we need to get construct an appropriate query. We can try:
> https://api.artic.edu/api/v1/artworks/search?q=cats&query[term][is_public_domain]=true&limit=3

So we do a search for the term "cats", restrict the query to items in the public domain, and limit our results list to 3 since we don't need a lot of options.

![Results list](../images/cat-cushion-search.png)

The first result I get, "Winter: Cat on a Cushion" looks promising. But how do I get more information about it? I look for the `api_link` value and plug that URL into my browser: [https://api.artic.edu/api/v1/artworks/51719](https://api.artic.edu/api/v1/artworks/51719).

Here, we get a lot more data as expected -- in fact, we're maybe overwhelmed by it. Where do we find the image? A `ctrl+f` search for "image" yields an `image_id` field:

![image_id field in the record](../images/cat-cushion-search.png)

What do we do with the `image_id`? The [Art Institute's image API documentation](https://api.artic.edu/docs/#images) includes good instructions, including this basic template for most use cases:

> https://www.artic.edu/iiif/2/{identifier}/full/843,/0/default.jpg

We now have the pieces we need to retrieve the image. Just replace the `{identifier}` in the template URL with the our `image_id` value. [Try it in your browser](https://www.artic.edu/iiif/2/e8e67721-bbb1-d007-82bd-c430ea73db70/full/843,/0/default.jpg). 

The last step is to use `curl` to download an image. Now is the time to go back to your command and enter the following command:

> `curl -o image.jpg https://www.artic.edu/iiif/2/2d484387-2509-5e8e-2c43-22f9981972eb/full/843,/0/default.jpg`

The `-o` specifies that `curl` should "output" to a file, which we have chosen to name `image.jpg`. Next, we simply simply the API request for the image. You should now see an `image.jpg` file in your folder.




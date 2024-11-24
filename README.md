## FetchStaffAssessment

My submission for Fetch's Staff iOS take home project https://d3jbb8n5wk0qxi.cloudfront.net/take-home-project.html

Note that the instructions specify to make a public repository. I would not leak or publish interview questions without permission.

### Steps to Run the App

1. Open the project in Xcode
2. Run the FetchStaffAssessment target (internet connection may be required to download the Swift package dependencies)

### Focus Areas: What specific areas of the project did you prioritize? Why did you choose to focus on these areas?

What I focused on the most are also the parts of the app that I'm least confident in, particularly whether my SwiftUI code is clean and idiomatic. As that is where I have relatively the least experience since my most recent job was mostly not using it yet, I needed to spend more time figuring out how to do things with it that I would have been extremely confident in with UIKit. For other focus areas, see the Additional Information section which goes over other areas I learned about in the process of doing this.

### Time Spent: Approximately how long did you spend working on this project? How did you allocate your time?

I spent about 6-7 hours writing the app itself, which was slow for me and the scope because of the time I spent adjusting to newer aspects of iOS development that I wasn't as familiar with (again, see additional information section). I spent probably about 1-2 hours on serialization, the recipe manager, tests for it, and manual testing. I spent about 2 hours getting the RecipeCell to look and work how I wanted it to. The recipe list took a bit under an hour for a version that didn't have any view model or other abstractions. Abstracting it to clean code and writing tests for the view model took about an hour. Final clean up, finishing touches, and the such took up a small portion of time as well.

I did spend a few hours before even starting on the app reading documentation and watching a few WWDC videos on things like Swift Testing and some of the Swift Concurrency topics like MainActor. While I was familiar with a lot of this from the announcements, I hadn't actually used them yet so my memory was pretty hazy.

### Trade-offs and Decisions: Did you make any significant trade-offs in your approach?

The biggest theme for trade offs in this project was how much to show what is actually appropriate for an app this scope vs trying to demonstrate what good practices are on more complex apps. I mostly ended on the side of making the choice most appropriate for this app while describing approaches that might be taken in other contexts. Much of my expertise is around good coding practices even at ridiculous scale of applications, so I wanted to demonstrate that. However, doing it too much in an app like this shows a lack of understanding of trade offs and whether some investment of effort to get a more robust design is actually worth anything. For example, I didn't spend the time to create a protocol for the RecipeViewModel and use that inside of the RecipeList because there isn't any UI testing anyway and I did get a chance to show that pattern with the RecipeManager.

### Weakest Part of the Project: What do you think is the weakest part of your project?

The UI code is likely the weakest part of the project. It is the first SwiftUI code I've written in about a year, and I did not write much of it back then. I'm not confident about how idiomatic it is, but thankfully the UI is simple enough that it likely doesn't seem too far from the norm.

### External Code and Dependencies: Did you use any external code, libraries, or dependencies?

1. Alamofire was chosen as it serves as a nice facade over the default NSURLSession APIs when making web requests with Swift Concurrency support built in.
2. Mocker from WeTransfer was chosen to help mock network requests. It was chosen primarily because it seemed to be one of the popular choices from some online searches. It feels a little clunkier to set up than other more general mocking tools I've used, and it prevents tests that do mocking from running in parralel, so it isn't actually a great choice but I kept it rather than finding a replacement.
3. SDWebImageSwiftUI is used for fetching and caching images. SDWebImage is one of the most popular and robust open source image loading libraries. While the AsyncImage view built in to SwiftUI is solid, it does not have as much control as SDWebImage offers and has no built in caching. It is certainly possible to build in the caching manually but SDWebImage already handles it effeciently (along with futureproofing for gifs and other image types). The primary consideration to NOT use it would be considerations around app size, as users on older phones can be very sensitive to app sizes.

### Additional Information: Is there anything else we should know? Feel free to share any insights or constraints you encountered.

Since my time building small apps was 6+ years ago, and apps the size of LinkedIn operate under a very different set of constraints, I learned to use a lot of the newer Swift/iOS/Xcode features for the first time building this app. For example:

1. I hadn't gotten to use Swift Concurrency as lower level libraries that I contributed to were predominantly in Objective-C.
2. We were not on the newest versions of Xcode so I've only written tests with the XCTest framework rather than the newer Swift Testing.
3. While I understand how SwiftUI works and how it translates into UIViews, my focus was on understanding how to support it, and what our company's migration plan for it should look like. I hadn't actually written very much UI code in it directly.

I chose to embrace all of these things as a learning opportunity, but with that also comes some consequences. Mostly, that I'm sure much of what I've done in those places could be done much more cleanly. For example, the parameterized testing is cool, but I don't think I've organized it particularly well. In the RecipeTests, for example, it looks pretty clunky with all of the parameters just listed in a blob at the bottom. The common pattern I saw online and replicated here of specifying two different collections and zipping them also isn't ideal. The parameters could get out of order, or one could be deleted from one collection but not the other, and it isn't obvious at all when that happens. I considered specifying the parameter as a Tuple or some named type that included both the input and expected output, but then the test code looks a bit more clunky. With some more experience, I'm sure I could identify an improved pattern for things like this.

### Attribution

The AppIcon image was collected from [Wannapik Studios](https://www.wannapik.com/vectors/34341?search%5Bcategory_id%5D=2050&search%5Blicense_id%5D=2&search%5Bportrait%5D=1) under the Creative Commons 3 license. 

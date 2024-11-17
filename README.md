## FetchStaffAssessment

My submission for Fetch's Staff iOS take home project https://d3jbb8n5wk0qxi.cloudfront.net/take-home-project.html 

### Steps to Run the App

### Focus Areas: What specific areas of the project did you prioritize? Why did you choose to focus on these areas?

### Time Spent: Approximately how long did you spend working on this project? How did you allocate your time?

### Trade-offs and Decisions: Did you make any significant trade-offs in your approach?

### Weakest Part of the Project: What do you think is the weakest part of your project?

### External Code and Dependencies: Did you use any external code, libraries, or dependencies?

1. Alamofire was chosen as it serves as a nice facade over the default NSURLSession APIs when making web requests with Swift Concurrency support built in.

### Additional Information: Is there anything else we should know? Feel free to share any insights or constraints you encountered.

Since my time building small apps was 6+ years ago, and apps the size of LinkedIn operate under a very different set of constraints, I learned to use a lot of the newer Swift/iOS/Xcode features for the first time building this app. For example:

1. I hadn't gotten to use Swift Concurrency as lower level libraries that I contributed to were predominantly in Objective-C.
2. We were not on the newest versions of Xcode so I've only written tests with the XCTest framework rather than the newer Swift Testing.
3. While I understand how SwiftUI works and how it translates into UIViews, my focus was on understanding how to support it, and what our company's migration plan for it should look like. I hadn't actually written very much UI code in it directly.

I chose to embrace all of these things as a learning opportunity, but with that also comes some consequences. Mostly, that I'm sure much of what I've done in those places could be done much more cleanly. For example, the parameterized testing is cool, but I don't think I've organized it particularly well. In the RecipeTests, for example, it looks pretty clunky with all of the parameters just listed in a blob at the bottom. The common pattern I saw online and replicated here of specifying two different collections and zipping them also isn't ideal. The parameters could get out of order, or one could be deleted from one collection but not the other, and it isn't obvious at all when that happens. I considered specifying the parameter as a Tuple or some named type that included both the input and expected output, but then the test code looks a bit more clunky. With some more experience, I'm sure I could identify an improved pattern for things like this.

### Attribution

The AppIcon image was collected from [Wannapik Studios](https://www.wannapik.com/vectors/34341?search%5Bcategory_id%5D=2050&search%5Blicense_id%5D=2&search%5Bportrait%5D=1) under the Creative Commons 3 license. 

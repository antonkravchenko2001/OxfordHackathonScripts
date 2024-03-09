import OpenAIKit
import UIKit
import Foundation

class AvatarGenerator {

    let apiKey = ""
    let orgId = ""
    private let client: OpenAI
    
    init(){
        let configuration: Configuration = Configuration(
            organizationId: orgId,
            apiKey: apiKey
        )
        client = OpenAI(configuration)
    }

    func generate(userInfo: UserInfo) async -> UIImage {
        let prompt = createAvatarPrompt(userInfo: userInfo)
        print("generating image for prompt: ", prompt)
        return await generateAvatarFromPrompt(prompt: prompt)
    }

    func generateAvatarFromPrompt(prompt: String) async -> UIImage {
        let imageParam = ImageParameters(
            // A text description of the desired image(s).
            prompt: prompt,
            // The size of the generated images.
            resolution: .small,
            // The format in which the generated images are returned.
            responseFormat: .base64Json
        )
        do {
            let result = try await client.createImage(parameters: imageParam)
            let b64Image = result.data[0].image
            let image = try openAi.decodeBase64Image(b64Image)
            return image
        } catch {
            return "An error occurred: \(error)"
        }
    }

    func createAvatarPrompt(userInfo: UserInfo) -> String {
        // create prompts array for efficient concatenation
        var prompts: [String] = []

        // create a base prompt
        let basePrompt: String = "Generate and image of a"
        prompts.append(basePrompt)
        let genderPrompt: String = userInfo.gender.lowercased() != "other" ? userInfo.gender : "person"
        prompts.append(genderPrompt)
        let agePrompt: String = "of \(userInfo.age) years old"
        prompts.append(agePrompt)
        let locationPrompt: String = userInfo.location != nil ? "that lives in \(userInfo.location!)" : ""
        prompts.append(locationPrompt)
        let profileDescriptionPrompt: String = userInfo.profileDescription != nil ? "and describes themselves as: \(userInfo.profileDescription!)." : ""
        prompts.append(profileDescriptionPrompt)

        // concat prompts into one prompt
        return prompts.joined(separator: " ")
    }
}


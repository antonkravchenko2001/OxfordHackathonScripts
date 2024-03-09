## Introduction

This file contains scripts for creating embeddings using Core ML formatted [Sentence Transformer](https://huggingface.co/sentence-transformers/all-MiniLM-L6-v2) and also for generating image Avatars using OpenAI api.


## Structure

The repo has two main modules:

1. `src/avatarGeneration/AvatarGenerator` - contains `AvatarGenerator` which is entry-point to generate images. The class contains method `generate` which is used to generate the image based on user info. 
   - ### IMPORTANT 1 !!!  In the commits we do not provide the the api key and org id. They should be pasted manually to the respective fields in the `AvatarGenerator` class.
   - ### IMPORTANT 2 !!!  In order to use AvatarGenerator [OpenAIKit](https://github.com/OpenDive/OpenAIKit) dependency has to be included

2. `src/embeddings/UserEmbedder` - contains `UserEmbedder` class which creates an embedding based on user info. The class contains `embed` method which generates the embedding. Inside `src/embeddings/` several important files are stored:
   - `vocab.txt` - contains vocabulary for the tokenizer and is used in its initialization. Make sure to add this file to the bundle
   - `BertEmbedder.mlmodel` - contains the actual core ml model
  


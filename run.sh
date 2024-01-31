cd models
git clone https://huggingface.co/meta-llama/Llama-2-7b-hf
cd ..
python3 convert.py models/Llama-2-7b-hf/
./build/bin/quantize models/Llama-2-7b-hf/ggml-model-f16.gguf models/Llama-2-7b-hf/ggml-model-q4_0.gguf q4_0

./build/bin/main -m ./models/Llama-2-7b-hf/ggml-model-q4_0.gguf -c 512 -b 1024 -n 256 --keep 48 \
    --repeat_penalty 1.0 --color -i \
    -r "User:" -f prompts/chat-with-bob.txt -ngl 33

./build/bin/main -m ./models/vicuna-7b-v1.5/ggml-model-q4_0.gguf -c 512 -b 1024 -n 256 --keep 48 \
    --repeat_penalty 1.0 --color -i \
    -r "User:" -f prompts/chat-with-bob.txt -ngl 33

./build/bin/main -m ./models/vicuna-7b-v1.5/ggml-model-q4_0.gguf -n 256 -ngl 33 --grammar-file \
    grammars/c.gbnf -p 'Generate a c code:'

./build/bin/main -m ./models/vicuna-7b-v1.5/ggml-model-q4_0.gguf -n 256 -ngl 33 --grammar-file \
    grammars/json.gbnf -p 'Output a json with 50 items:'

./build/bin/main -m ./models/vicuna-7b-v1.5/ggml-model-q4_0.gguf -n 256 -ngl 33 --grammar-file \
    grammars/list.gbnf -p 'Output a json of a two-layer array:'

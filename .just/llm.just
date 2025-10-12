##########################################################################################
# Recursively aggregate all *.md files content into single llm.txt one
##########################################################################################

[doc('collect all *.md files into single llm.txt')]
[no-cd]
[script('bash')]
llm:
    just app project_support deno run -A src/lib/llm_txt_from_all_md.ts --root="$(pwd)"

##########################################################################################
# For copilot integration, the copilot task additionally collect it
# in .github/copilot-context.md so it will be auto-attached to each prompt.
##########################################################################################

[doc('the same as <just llm> but additionally place specifically for copilot')]
[no-cd]
[script('bash')]
copilot:
    if [ ! -d ".github" ]; then
        just printError "Error: .github folder not found in current directory."
        exit 1
    fi
    just llm
    mv llm.txt .github/copilot-instructions.md
    just printInfo "✅ Copilot instructions updated at .github/copilot-instructions.md"

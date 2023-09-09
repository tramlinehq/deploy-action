# Tramline Deploy Action for GitHub

This allows for a more seamless experience integrating Tramline with your CI workflows.

See [action.yml](action.yml).

## Usage

Set up your workflow to accept inputs on dispatch.

```yaml
on:
  workflow_dispatch:
    inputs:
      tramline-input:
        required: false
```

Add this step to your workflow. This step also runs the `checkout` against the correct commit SHA passed in by Tramline. So you don't need to add an additional `actions/checkout@v3` step.

```yaml
steps:
  - name: Configure Tramline
    id: tramline
    uses: tramlinehq/deploy-action@v0.1.5
    with:
      input: ${{ github.event.inputs.tramline-input }}
```

You can now use the following outputs from this step:

1. `steps.tramline.outputs.version_code`
2. `steps.tramline.outputs.version_name`

Optionally,

1. `steps.tramline.outputs.commit_ref`
2. `steps.tramline.outputs.build_notes`
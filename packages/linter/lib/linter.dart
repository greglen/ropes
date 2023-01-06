/// The linter package doesn't ship any source code.
///
/// To enable `linter`,
/// 1. Add it to your dev_dependencies
/// ```yaml
/// dev_dependencies:
///   linter:
///     path: ../linter
/// ```
///
/// 2. Include the rules into your `analysis_options.yaml`
/// ```yaml
/// include: package:linter/analysis_options.yaml
/// ```
library linter;

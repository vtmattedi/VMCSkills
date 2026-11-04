# Frontend architecture presets and decision triggers

Use as a menu of trade-offs, not scaffolding instructions.

| Preset | Prefer when | Usually avoid |
| --- | --- | --- |
| Minimal | Few routes and simple state | Nested feature layers, global state frameworks |
| Feature/workflow | Multiple business capabilities with workflow-specific UI and APIs | `components/` as a dumping ground; type-only folder grouping |
| Dashboard/console | Operational shell and substantial cross-cutting status/real-time views | Splitting every small settings page into four files |
| Content | Pages/content/layout change independently of business APIs | Unnecessary data-service/domain layers |
| Hybrid | Different parts have genuinely different complexity | Mandating the same layout in every module |

## Decisions to make from observed code

1. **Ownership:** Which feature or page is responsible for each workflow? What presentation is truly shared?
2. **State:** Which state belongs in URL/router, server-state layer, feature hooks, or local component? What is authoritative?
3. **Data:** Are API operations typed and localized? Is a query cache appropriate or is explicit fetching clearer? Preserve the selected strategy unless change evidence justifies migration.
4. **Boundaries:** Which imports are allowed? Keep shared low-level layers from depending on domain owners. Prefer direct imports when a barrel obscures ownership.
5. **Splitting:** Prefer by responsibility and interaction flow. A multi-screen feature can use `list/`, `new/`, `detail/`; small features remain flat.
6. **Experience:** Can loading, empty, permission-denied, stale, conflict, failure and recovery states be understood and tested?
7. **Framework:** Respect existing idioms and constraints; choose SSR, client rendering, caching, design systems, forms, styling and i18n from requirements, not fashion.

## Reference contrasts

- **tripleA-work:** business feature ownership, focused API calls, local workflow hooks and pure shared contracts. Its no-global-cache decision is specific to its application.
- **Stackport:** a console with deployment orchestration, streaming status and operations; a shared query layer may be appropriate.
- **personal-site:** content and layout structure can stay lightweight.

These are examples of *reasoning*, not templates to copy or universal library recommendations.

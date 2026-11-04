# Backend structural presets

Choose from runtime needs and responsibility boundaries, not a preferred diagram.

| Preset | Good fit | Boundary priority |
| --- | --- | --- |
| Minimal service | Three endpoints, small utility | Simple readable handlers and helpers |
| Domain/workflow | Purchase-order approvals, transactional business operations | Actor/auth, domain rules, transaction owner, persistence |
| Integration/orchestrator | Deployment systems, webhook coordinators, notification aggregator | Adapters, durable state, sequencing, retries and reconciliation |
| Language-native package | Go service with cohesive packages | Clear package responsibilities, interfaces only at actual seams |
| Protocol/device | ESP32 networking and firmware | Transport, protocol framing, state machine and bounded resources |

## Reference contrasts

- **tripleA-work:** `modules/<capability>/routes.ts`, `service.ts`, `repository.ts`, `entities.ts` fit its rules and transaction model. Apply only when independently justified.
- **Stackport:** Docker, reverse proxy, GitHub and deployment lifecycles call for orchestration and adapters. Not every operation is CRUD.
- **MW Identity:** Go `httpapi`, `auth`, `oidc`, `applications`, `store/sqlite` packages reflect its ecosystem. Avoid replicating TS folder conventions.
- **NightMare Network:** protocol and timing invariants dictate placement before any web-service conventions.

## Evidence-based design questions

- Which operations must be atomic, ordered or recoverable? Who owns that boundary?
- Which components know external SDKs, SQL schema, HTTP status codes and core business decisions? Is that knowledge appropriate?
- What is the authoritative state and what is merely a hint/cache?
- Are transport details leaking into policy, or domain decisions leaking into repositories?
- Is one layer doing unrelated work, or do several thin layers merely forward calls?
- Would a smaller package or extraction reduce independent reasons to change?
- Do tests genuinely reproduce the behavior whose safety the reorganization claims to preserve?
- Does the proposed architecture increase deployment, runtime, or cognitive cost without justified benefits?

Document trade-offs, explicitly including options not selected.

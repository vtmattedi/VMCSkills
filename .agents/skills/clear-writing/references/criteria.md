# Clear-writing review criteria

These are prompts for judgment, not a blacklist. A word, structure, or tone is only a defect when it obscures meaning, inflates claims, repeats information, or conflicts with the requested audience.

## What to inspect

| Signal | Diagnose | Better response |
| --- | --- | --- |
| Unsupported superlative | "revolutionary", "best-in-class", "production-ready" without proof | State a measurable property or remove the claim |
| Empty business jargon | "leverage", "streamline", "empower" without a described operation | Name the actor, action, input, and outcome |
| Repeated conclusions | Opening, summary, and closing say the same thing | Keep one useful statement |
| Performative agreement | "Great question!", "excellent decision" regardless of evidence | Answer or assess the substance |
| Mechanical structure | Every paragraph is a bullet or every answer has a conclusion | Structure for scanning, not symmetry |
| Artificial hedging | "may potentially possibly" or vague caution | State exactly what is unknown and why |
| False confidence | Performance, compatibility, impact asserted without evidence | Identify assumption, source, or test needed |
| Flat tone | Author's justified voice removed during "cleanup" | Retain intentional conversational or distinctive language |
| Technical drift | Rephrasing changes whether a feature is promised, optional, or tested | Keep the contract and exact literals intact |
| Monolingual assumption | Rewriting localized interface strings without locale rules | Preserve keys, variables, plural forms and configured locales |

## Contrasting examples

**Marketing fog**

Before: "Our innovative solution seamlessly empowers teams to effortlessly manage projects."

After, if supported: "The app brings project tasks, owners, and deadlines into one view."

Why: describes an actual operation, without claiming performance or user outcomes.

**Overcompression can be wrong**

Source: "The token is valid for five minutes. After expiry, clients must request a new token. Existing refresh tokens remain valid."

Bad rewrite: "Tokens expire quickly and can be renewed."

Good rewrite: "Access tokens expire after five minutes. Clients must then obtain a new access token; refresh tokens remain valid."

Why: concise, but retains independently important semantics.

**Technical uncertainty**

Before: "This deployment is fully safe and will never drop traffic."

Better: "The proposed rollout keeps the existing route until health checks pass. We have not yet tested failure during certificate renewal."

Why: distinguishes mechanism from unverified reliability claim.

**Intentional informal voice**

Source: "This is a tiny tool; don't overthink it."

Do not rewrite as: "This streamlined solution prioritizes simplicity."

Why: the author's voice conveys useful scope.

## Review checklist

1. Can the reader identify the core claim and action?
2. Are all factual claims grounded in provided or inspected information?
3. Are constraints, uncertainty, caveats, and technical literals preserved?
4. Does each sentence add information, context, or personality appropriate to the task?
5. Is the structure earned by complexity?
6. Do the words match the audience's domain and the author's language/voice?
7. Would the rewrite change any implied promise, responsibility, or security boundary?
8. Can the reviewer explain *why* each proposed edit improves the text?

## Stopping rule

KEEP when the text is already precise and suited to the audience. Prefer a few meaningful corrections over a complete rewrite that only sounds different. No fabricated metrics, citations, endorsements, or test results.

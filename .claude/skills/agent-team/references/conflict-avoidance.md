# Conflict Avoidance in Agent Teams

## Core Rule

**One teammate per file.** Two teammates editing the same file leads to overwrites. Break work so each teammate owns a distinct set of files.

## File Ownership Assignment

Before spawning teammates, the lead must:

1. **List all files** that will be created or modified
2. **Assign each file** to exactly one teammate
3. **Include file assignments** in each teammate's spawn prompt
4. **Declare shared files** that the lead will own (interfaces, types, configs)

### Example Assignment

```
Feature: User notifications system

Shared (lead owns, defines BEFORE teammates start):
  src/shared/notification.types.ts

Teammate "api" owns:
  src/api/notifications/routes.ts
  src/api/notifications/handlers.ts
  src/api/notifications/validation.ts
  tests/api/notifications.test.ts

Teammate "service" owns:
  src/services/notification/sender.ts
  src/services/notification/templates.ts
  src/services/notification/queue.ts
  tests/services/notification.test.ts

Teammate "ui" owns:
  src/components/NotificationBell.tsx
  src/components/NotificationList.tsx
  src/hooks/useNotifications.ts
  tests/components/notifications.test.tsx
```

## Shared Contracts

The lead defines shared contracts (types, interfaces, API boundaries) BEFORE any teammate starts implementation. This is non-negotiable.

**Why**: Without agreed-upon interfaces, teammates make incompatible assumptions. Teammate A expects `userId: string`, teammate B sends `user_id: number`. Discovering this at integration wastes all the parallelism gains.

**Process**:
1. Lead creates shared type/interface files
2. Lead commits them
3. Lead spawns teammates with instruction: "Import types from src/shared/, do not redefine them"

## When a Teammate Needs Another's File

If a teammate discovers it needs to modify a file owned by another teammate:

1. **Message the owner** via direct messaging: "I need to add field X to your interface in file Y"
2. **Wait for the owner** to make the change (or confirm it's safe to proceed)
3. **Never modify another teammate's file** directly

If the owner has already finished and gone idle:
1. Message the lead
2. Lead reassigns the file or makes the change directly

## Cross-Cutting Concerns

Some changes naturally span multiple files (logging format, error handling pattern, config changes). These belong to the lead:

- **Config files** (package.json, tsconfig, .env.example): Lead only
- **Shared utilities** that multiple teammates import: Lead defines first
- **Database migrations**: Lead only (ordering matters)
- **CI/CD changes**: Lead only

## Integration Phase

After all teammates complete their tasks:

1. Lead verifies no file conflicts (should be impossible with proper ownership)
2. Lead writes integration tests that span module boundaries
3. Lead runs full test suite
4. Lead resolves any interface mismatches (shouldn't happen if contracts were defined first)

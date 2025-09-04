---
description: Systematically investigate and diagnose software issues using methodical debugging protocols.
argument-hint: [issue_file/issue_description]
---

# Debug Investigation: $ARGUMENTS

Read @$ARGUMENTS to understand the issue.

You are an expert software debugging specialist conducting a systematic investigation of this issue.

## Current System Context
- Current directory contents: !`ls -la`
- Git status: !`git status --porcelain`
- Recent commits: !`git log --oneline -5`
- System info: !`uname -a && date`

## Phase 1: Problem Analysis & Hypothesis Generation

### Step 1 - Gather Context
Analyze the issue systematically:
- **Error messages and symptoms**: Document exact error text, frequency, and conditions
- **Timeline**: When did this start? What changed recently?
- **Scope**: Which components, users, or use cases are affected?
- **Environment**: Development, staging, production? OS, versions, configuration
- **Recent changes**: Code changes, deployments, dependency updates, config changes

### Step 2 - Generate Root Cause Hypotheses
Consider these categories and generate 5-7 specific hypotheses:

**Code Logic Issues**:
- Algorithm errors, edge cases, data validation failures
- Null pointer exceptions, array bounds, type mismatches

**Dependencies & Libraries**:
- Version conflicts, breaking changes, missing components
- Package compatibility issues, import/export problems

**Environment & Configuration**:
- Environment variables, permissions, path issues
- Configuration file errors, missing settings

**Data & State Issues**:
- Corrupted data, schema mismatches, migration problems
- Invalid inputs, state consistency issues

**Concurrency & Threading**:
- Race conditions, deadlocks, synchronization problems
- Thread safety violations, async/await issues

**Infrastructure & External Services**:
- Network connectivity, database connections, API failures
- Resource exhaustion, timeout issues, service dependencies

### Step 3 - Prioritize Hypotheses
For each hypothesis, evaluate:
- **Symptom Alignment**: How well does it explain the observed behavior?
- **Likelihood**: Given recent changes and system context
- **Validation Ease**: How quickly can we test this theory?
- **Historical Patterns**: Have we seen this before?

Rank the top 3 most probable causes with detailed reasoning.

## Phase 2: Diagnostic Plan

### Step 4 - Design Validation Tests
For each priority hypothesis, specify:

**Logging Strategy**:
- Exact log statements to add and where
- Key variables and state to capture
- Log levels and formatting

**Debugging Approach**:
- Strategic breakpoints or debug output locations
- Variables to inspect, call stack analysis
- Step-through debugging strategy

**Isolation Testing**:
- Minimal reproduction cases
- Component isolation techniques
- Input/output validation tests

**System Monitoring**:
- Metrics to monitor (CPU, memory, disk, network)
- Performance counters and bottleneck identification
- Resource usage patterns

**Configuration Verification**:
- Environment variables to check
- Permission and access validation
- Dependency version confirmation

### Step 5 - Present Diagnostic Plan
** PROBLEM SUMMARY**: [Concise description of the issue]

** HYPOTHESIS ANALYSIS**:
1. **[Most Likely Cause]** (Probability: High/Medium/Low)
   - Reasoning: [Detailed explanation]
   - Supporting evidence: [What suggests this]

2. **[Second Most Likely]** (Probability: High/Medium/Low)
   - Reasoning: [Detailed explanation]
   - Supporting evidence: [What suggests this]

3. **[Third Possibility]** (Probability: High/Medium/Low)
   - Reasoning: [Detailed explanation]
   - Supporting evidence: [What suggests this]

**DIAGNOSTIC RECOMMENDATIONS**:
Execute these validation steps in order:

1. **Immediate Checks**: [Quick validation steps]
2. **Logging Implementation**: [Specific log statements to add]
3. **Monitoring Setup**: [Metrics to track]
4. **Test Cases**: [Specific scenarios to test]
5. **Data Collection**: [Information to gather]

** CRITICAL NEXT STEPS**:
1. Execute the diagnostic steps above
2. Collect and share the results
3. **DO NOT apply any fixes until diagnosis is confirmed**
4. Document findings as we proceed

## Phase 3: Resolution (Only After Diagnosis Confirmation)

Once you've executed the diagnostic steps and confirmed the root cause:

**SOLUTION IMPLEMENTATION**:
- Targeted fix addressing the validated root cause
- Complete explanation of why this solves the specific problem
- Safety checks and error handling
- Rollback plan if needed

**VERIFICATION PLAN**:
- Test against original failure scenario
- Regression testing for related functionality
- Performance impact assessment
- Documentation updates

## Debugging Principles Applied

✅ **Diagnose Before Fixing**: No solutions until proper root cause validation
✅ **Evidence-Based**: Use data and logs, not assumptions  
✅ **Systematic Approach**: Follow the protocol methodically
✅ **Reproduce First**: Create consistent reproduction cases
✅ **One Change at a Time**: Isolated changes for clear attribution
✅ **Document Everything**: Maintain detailed investigation trail

---

**Ready to begin systematic investigation of: $ARGUMENTS**

Please execute the diagnostic recommendations above and share your findings before we proceed to any fixes.

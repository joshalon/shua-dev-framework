# MCP Server Setup — Skill Reference

This skill provides guidance on building, configuring, and deploying MCP servers.

## What Is MCP

Model Context Protocol — an open standard for connecting AI models to external tools and data. Standardized, modular, secure, dynamic.

## Architecture

- **Host**: Application containing the LLM (Claude Code, Cursor, etc.)
- **Client**: Lightweight process maintaining 1:1 connection to a server
- **Server**: Exposes capabilities (tools, resources, prompts) in a standardized way

## Three Primitives

| Primitive | Analogy | Purpose | Control |
|-----------|---------|---------|---------|
| Tools | POST endpoints | Executable functions with side effects | Model-controlled |
| Resources | GET endpoints | Read-only data sources | App-controlled |
| Prompts | Templates | Reusable instruction templates | User-controlled |

## Python Server Skeleton (FastMCP)

```python
from mcp.server.fastmcp import FastMCP

mcp = FastMCP("server-name")

@mcp.tool()
def my_tool(param: str) -> str:
    """Clear description for the LLM. Args: param: What this parameter is."""
    return result

@mcp.resource("config://settings")
def get_settings() -> str:
    """Read-only data source."""
    return json.dumps(settings)

@mcp.prompt()
def my_prompt(context: str) -> str:
    """Reusable prompt template. Args: context: The context to use."""
    return f"Do X with {context}"

if __name__ == "__main__":
    mcp.run(transport="stdio")
```

## Critical Rules

- **STDIO servers: NEVER use print() to stdout** — it corrupts JSON-RPC messages. Use `logging.info()` or `print(..., file=sys.stderr)`.
- Python 3.10+ required, MCP SDK 1.2.0+
- Use `uv` as package manager
- Config paths must be ABSOLUTE, not relative
- Fully restart the client after config changes

## Claude Code MCP Commands

- `claude mcp add <name> -- <cmd>` — Add local STDIO server
- `claude mcp add --transport http <name> <url>` — Add remote HTTP server
- `claude mcp list` — List configured servers
- `claude mcp remove <name>` — Remove a server
- `mcp dev server.py` — Launch Inspector for testing

## Configuration Scopes

- **Local** (`~/.claude.json` project path): Personal dev servers, experimental
- **Project** (`.mcp.json` in project root): Shared team servers, committed to repo
- **User** (`~/.claude.json` global): Available across all projects

## Security Checklist

- Only expose minimum capabilities needed
- Validate all LLM-generated parameters as untrusted input
- Never hardcode API keys — use environment variables
- Log all tool invocations for audit
- Review source code of third-party servers before installing

## Debugging

- Check logs: `tail -n 20 -f ~/Library/Logs/Claude/mcp*.log`
- Test standalone: `uv run server.py`
- Test with Inspector: `mcp dev server.py`
- Verify no print() to stdout in STDIO servers
- Ensure full paths in config (find with `which uv`)

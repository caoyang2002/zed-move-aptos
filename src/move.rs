use zed_extension_api::{
    self as zed,
    lsp::{Completion, CompletionKind},
    CodeLabel, CodeLabelSpan, LanguageServerId, Result,
};
// MoveExtension 结构体定义，用于存储 Move 语言分析器的缓存路径
struct MoveExtension {
    cached_binary_path: Option<String>,
}
// MoveExtension 的实现块，包含辅助方法
impl MoveExtension {
    // 获取语言服务器命令的辅助方法
    fn language_server_command(
        &mut self,
        _server_id: &zed::LanguageServerId,
        worktree: &zed::Worktree,
    ) -> Result<String> {
        println!("开始获取语言服务命令");
        // 在 PATH 中查找 move-analyzer，如果找不到则返回错误
        worktree
            .which("move-analyzer")
            .ok_or("move-analyzer not found in PATH, falling back to bundled binary".to_string())
    }
    // 为不同类型的代码补全生成标签的辅助方法
    fn label_for_completion(
        &self,
        _server_id: &LanguageServerId,
        completion: Completion,
    ) -> Option<CodeLabel> {
        // 根据补全类型生成不同的标签
        match completion.kind? {
            // 函数补全
            CompletionKind::Function => {
                let func = "func ";
                let mut return_type = String::new();
                // 如果有返回类型详情，则添加到标签中
                if let Some(detail) = completion.detail {
                    if !detail.is_empty() {
                        return_type = format!(" -> {detail}");
                    }
                }

                let before_braces = format!("{func}{}{return_type}", completion.label);
                let code = format!("{before_braces} {{}}");

                Some(CodeLabel {
                    code,
                    spans: vec![CodeLabelSpan::code_range(func.len()..before_braces.len())],
                    filter_range: (0..completion.label.find('(')?).into(),
                })
            }
            // 变量补全
            CompletionKind::Variable => {
                let var = "var ";
                let code = format!("{var}{}: {}", completion.label, completion.detail?);

                Some(CodeLabel {
                    spans: vec![CodeLabelSpan::code_range(var.len()..code.len())],
                    code,
                    filter_range: (0..completion.label.len()).into(),
                })
            }
            // 值补全
            CompletionKind::Value => {
                let mut r#type = String::new();

                if let Some(detail) = completion.detail {
                    if !detail.is_empty() {
                        r#type = format!(": {detail}");
                    }
                }

                let var = format!("var variable{type} = ");
                let code = format!("{var}{}", completion.label);

                Some(CodeLabel {
                    spans: vec![CodeLabelSpan::code_range(var.len()..code.len())],
                    code,
                    filter_range: (0..completion.label.len()).into(),
                })
            }
            CompletionKind::Class
            | CompletionKind::Interface
            | CompletionKind::Module
            | CompletionKind::Enum
            | CompletionKind::Keyword
            | CompletionKind::Struct => {
                let highlight_name = match completion.kind? {
                    CompletionKind::Class
                    | CompletionKind::Interface
                    | CompletionKind::Enum
                    | CompletionKind::Struct => Some("type".to_string()),
                    CompletionKind::Keyword => Some("keyword".to_string()),
                    _ => None,
                };

                Some(CodeLabel {
                    code: Default::default(),
                    filter_range: (0..completion.label.len()).into(),
                    spans: vec![CodeLabelSpan::literal(completion.label, highlight_name)],
                })
            }
            // 枚举补全
            CompletionKind::EnumMember => {
                let start = "enum Enum { case ";
                let code = format!("{start}{} }}", completion.label);

                Some(CodeLabel {
                    code,
                    spans: vec![CodeLabelSpan::code_range(
                        start.len()..start.len() + completion.label.len(),
                    )],
                    filter_range: (0..completion.label.find('(').unwrap_or(completion.label.len()))
                        .into(),
                })
            }
            CompletionKind::TypeParameter => {
                let typealias = "typealias ";
                let code = format!("{typealias}{} = {}", completion.label, completion.detail?);

                Some(CodeLabel {
                    spans: vec![CodeLabelSpan::code_range(typealias.len()..code.len())],
                    code,
                    filter_range: (0..completion.label.len()).into(),
                })
            }
            _ => None,
        }
    }
}
// 实现 zed::Extension trait，提供扩展所需的核心功能
impl zed::Extension for MoveExtension {
    // 创建新的扩展实例
    fn new() -> Self {
        Self {
            cached_binary_path: None,
        }
    }

    // 生成语言服务器命令
    fn language_server_command(
        &mut self,
        server_id: &zed::LanguageServerId,
        worktree: &zed::Worktree,
    ) -> Result<zed::Command> {
        Ok(zed::Command {
            command: self.language_server_command(server_id, worktree)?,
            args: vec![],
            env: Default::default(),
        })
    }

    // 处理代码补全的标签生成
    fn label_for_completion(
        &self,
        server_id: &LanguageServerId,
        completion: Completion,
    ) -> Option<CodeLabel> {
        self.label_for_completion(server_id, completion)
    }
}

// 注册 MoveExtension 作为 Zed 编辑器的扩展
zed::register_extension!(MoveExtension);

/// A configuration value for a rule to allow users to modify its behavior.
public protocol RuleConfiguration: InlinableOptionType {
    /// The type of the rule that's using this configuration.
    associatedtype Parent: Rule

    /// A description for this configuration's parameters. It can be built using the annotated result builder.
    @RuleConfigurationDescriptionBuilder
    var parameterDescription: RuleConfigurationDescription? { get }

    /// Apply an untyped configuration to the current value.
    ///
    /// - parameter configuration: The untyped configuration value to apply.
    ///
    /// - throws: Throws if the configuration is not in the expected format.
    mutating func apply(configuration: Any) throws

    /// Whether the specified configuration is equivalent to the current value.
    ///
    /// - parameter ruleConfiguration: The rule configuration to compare against.
    ///
    /// - returns: Whether the specified configuration is equivalent to the current value.
    func isEqualTo(_ ruleConfiguration: some RuleConfiguration) -> Bool
}

/// A configuration for a rule that allows to configure at least the severity.
public protocol SeverityBasedRuleConfiguration: RuleConfiguration {
    /// The configuration of a rule's severity.
    var severityConfiguration: SeverityConfiguration<Parent> { get }
}

public extension SeverityBasedRuleConfiguration {
    /// The severity of a rule.
    var severity: ViolationSeverity {
        severityConfiguration.severity
    }
}

public extension RuleConfiguration where Self: Equatable {
    func isEqualTo(_ ruleConfiguration: some RuleConfiguration) -> Bool {
        return self == ruleConfiguration as? Self
    }
}

public extension RuleConfiguration {
    var parameterDescription: RuleConfigurationDescription? { nil }
}

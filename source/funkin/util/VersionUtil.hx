package funkin.util;

import thx.semver.Version;
import thx.semver.VersionRule;

/**
 * Utility functions for operating on semantic versions.
 *
 * Remember, increment the patch version (1.0.x) if you make a bugfix,
 * increment the minor version (1.x.0) if you make a new feature (but previous content is still compatible),
 * and increment the major version (x.0.0) if you make a breaking change (e.g. new API or reorganized file format).
 */
class VersionUtil
{
  /**
   * Checks that a given verison number satisisfies a given version rule.
   * Version rule can be complex, e.g. "1.0.x" or ">=1.0.0,<1.1.0", or anything NPM supports.
   */
  public static function validateVersion(version:thx.semver.Version, versionRule:thx.semver.VersionRule):Bool
  {
    try
    {
      return version.satisfies(versionRule);
    }
    catch (e)
    {
      trace('[VERSIONUTIL] Invalid semantic version: ${version}');
      return false;
    }
  }

  /**
   * Checks that a given verison number satisisfies a given version rule.
   * Version rule can be complex, e.g. "1.0.x" or ">=1.0.0,<1.1.0", or anything NPM supports.
   */
  public static function validateVersionStr(version:String, versionRule:String):Bool
  {
    try
    {
      var version:thx.semver.Version = version;
      var versionRule:thx.semver.VersionRule = versionRule;
      return version.satisfies(versionRule);
    }
    catch (e)
    {
      trace('[VERSIONUTIL] Invalid semantic version: ${version}');
      return false;
    }
  }

  /**
   * Get and parse the semantic version from a JSON string.
   * @param input The JSON string to parse.
   * @return The semantic version, or null if it could not be parsed.
   */
  public static function getVersionFromJSON(input:Null<String>):Null<thx.semver.Version>
  {
    if (input == null) return null;
    var parsed = SerializerUtil.fromJSON(input);
    if (parsed == null) return null;
    if (parsed.version == null) return null;
    var versionStr:String = parsed.version; // Dynamic -> String cast
    var version:thx.semver.Version = versionStr; // Implicit, not explicit, cast.
    return version;
  }
}

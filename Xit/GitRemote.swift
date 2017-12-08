import Cocoa

public protocol Remote: class
{
  var name: String? { get }
  var urlString: String? { get }
  var pushURLString: String? { get }
  
  func rename(_ name: String) throws
  func updateURLString(_ URLString: String) throws
  func updatePushURLString(_ URLString: String) throws
}

class GitRemote: Remote
{
  let remote: OpaquePointer
  
  var name: String?
  {
    guard let name = git_remote_name(remote)
    else { return nil }
    
    return String(cString: name)
  }

  var urlString: String?
  {
    guard let url = git_remote_url(remote)
    else { return nil }
    
    return String(cString: url)
  }
  
  var pushURLString: String?
  {
    guard let url = git_remote_pushurl(remote)
    else { return nil }
    
    return String(cString: url)
  }
  
  init?(name: String, repository: OpaquePointer)
  {
    let remote = UnsafeMutablePointer<OpaquePointer?>.allocate(capacity: 1)
    let result = git_remote_lookup(remote, repository, name)
    guard result == 0,
          let finalRemote = remote.pointee
    else { return nil }
    
    self.remote = finalRemote
  }

  func rename(_ name: String) throws
  {
    guard let oldName = git_remote_name(remote),
          let owner = git_remote_owner(remote)
    else { throw XTRepository.Error.unexpected }
    
    let problems = UnsafeMutablePointer<git_strarray>.allocate(capacity: 1)
    let result = git_remote_rename(problems, owner, oldName, name)
    
    try XTRepository.Error.throwIfError(result)
  }
  
  func updateURLString(_ URLString: String) throws
  {
    guard let name = git_remote_name(remote),
          let owner = git_remote_owner(remote)
    else { throw XTRepository.Error.unexpected }
    let result = git_remote_set_url(owner, name, URLString)
    
    try XTRepository.Error.throwIfError(result)
  }
  
  func updatePushURLString(_ URLString: String) throws
  {
    guard let name = git_remote_name(remote),
          let owner = git_remote_owner(remote)
    else { throw XTRepository.Error.unexpected }
    let result = git_remote_set_pushurl(owner, name, URLString)
    
    try XTRepository.Error.throwIfError(result)
  }
}
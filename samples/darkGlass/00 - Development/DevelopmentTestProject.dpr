//------------------------------------------------------------------------------
// This file is part of the DarkGlass game engine project.
// More information can be found here: http://chapmanworld.com/darkglass
//
// DarkGlass is licensed under the MIT License:
//
// Copyright 2018 Craig Chapman
//
// Permission is hereby granted, free of charge, to any person obtaining a
// copy of this software and associated documentation files (the �Software�),
// to deal in the Software without restriction, including without limitation
// the rights to use, copy, modify, merge, publish, distribute, sublicense,
// and/or sell copies of the Software, and to permit persons to whom the
// Software is furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included
// in all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED �AS IS�, WITHOUT WARRANTY OF ANY KIND,
// EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
// MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
// IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM,
// DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
// OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE
// USE OR OTHER DEALINGS IN THE SOFTWARE.
//------------------------------------------------------------------------------
program DevelopmentTestProject;
uses
  darkglass,
  darkglass.static,
  darkplatform.messages,
  sysutils;

function HandleMessage( aMessage: TMessage ): nativeuint;
var
  PlatformPipe: THandle;
  Response: nativeuint;
begin
  Result := 0;
  case aMessage.Value of

    TPlatform.MSG_PLATFORM_INITIALIZED: begin
      PlatformPipe := dgGetMessagePipe(Pointer(UTF8Encode('platform')));
      Response := dgSendMessageWait(PlatformPipe, TPlatform.MSG_PLATFORM_CREATE_WINDOW, 100, 100, 0, 0 );

      // Create a log file and send a message to it.
      Response := dgSendMessageWait(PlatformPipe, TPlatform.MSG_PLATFORM_GET_LOGFILE_HANDLE, nativeuint(pansichar('darkTest.log')), 0, 0, 0);
      dgSendMessageWait(PlatformPipe, TPlatform.MSG_PLATFORM_LOG, nativeuint(pansichar('Oh goodness me, logging works!')), Response, 0, 0 );

    end;

    else begin
      Result := 0;
    end;
  end;
end;

begin
  dgInitialize(HandleMessage);
  try
    dgRun;
  finally
   dgFinalize;
  end;
end.

import qaiLogoLight from "../assets/images/logo-qai-oficial.png"
import qaiLogoDark from "../assets/images/logo-qai-oficial.png"
import { ComponentProps } from "solid-js"

const getPreferredLogo = (): string => {
  if (typeof document === "undefined") return qaiLogoLight
  const html = document.documentElement
  const scheme = html.dataset.colorScheme
  return scheme === "dark" ? qaiLogoDark : qaiLogoLight
}

export const Mark = (props: { class?: string }) => (
  <img data-component="logo-mark" src={getPreferredLogo()} classList={{ [props.class ?? ""]: !!props.class }} />
)

export const Splash = (props: Pick<ComponentProps<"img">, "ref" | "class">) => (
  <img
    ref={props.ref}
    data-component="logo-splash"
    src={getPreferredLogo()}
    classList={{ [props.class ?? ""]: !!props.class }}
  />
)

export const Logo = (props: { class?: string }) => (
  <img data-component="logo-splash" src={getPreferredLogo()} classList={{ [props.class ?? ""]: !!props.class }} />
)
